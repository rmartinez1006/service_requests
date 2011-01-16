module Common

   #Para usar las funciones definidas en este modulo dentro de una clase
   #solo hay que agregar la sentencia:
   #
   #include Common
   #
   #dentro de la clase

   def test()
      #funcion de ejemplo uso comun
   end

   def get_status_id(lv_status)
     r= 0
     #lv_sql = "SELECT id FROM catalogs_request_statuses "+
     #         " WHERE abbr ='" + lv_status +"'"
     @status = Catalogs::RequestStatus.find(:first, :conditions => "abbr = '"+lv_status +"'")
     if @status
       r= @status.id
     end
     r
   end

   def get_status_abbr(lv_id)
     r= 'ST01'
     @status = Catalogs::RequestStatus.find(lv_id)
     if @status
       r= @status.abbr
     end
     r
   end
 
   # Asignar el estatus a la solicitud
   def set_status_id_req(support_request_id, status)
     @requests_support_request = RequestsAdministration::SupportRequest.find(support_request_id)
     if @requests_support_request
        @requests_support_request.request_status_id = get_status_id(status)
        @requests_support_request.save
     end   
   end

   # Obtener el número de autorización siguiente del presupuesto (Por ID de Presupuesto)
   # budget_id => ID del presupuesto
   # 1 = Primer autorización (Analista)
   # 2 = Segunda autorización (Coordinador) --Pre-liberación
   # 3 = Tercer autorización (Coordinador) -- Liberado (Autorización final) Coordinador
   def get_num_aut(budget_id)
     r = 1
     lv_aux ="SELECT * FROM request_commentaries com, catalogs_comment_types typ
                   WHERE com.comment_type_id = typ.id
                     AND com.budget_id =".concat(budget_id.to_s)     
     lv_sql = lv_aux + " AND typ.abbr ='AUT-P01'"

     @commentary_aut01 = RequestsAdministration::Commentary.find_by_sql(lv_sql)
     if not @commentary_aut01.empty?
        r = 2
        lv_sql = lv_aux + " AND typ.abbr ='AUT-P02'"
        @commentary_aut02 = RequestsAdministration::Commentary.find_by_sql(lv_sql)
        if not @commentary_aut02.empty?
           r = 3
           lv_sql = lv_aux + " AND typ.abbr ='AUT-P03'"
           @commentary_aut03 = RequestsAdministration::Commentary.find_by_sql(lv_sql)
           if not @commentary_aut03.empty?
               lv_sql = lv_aux + " AND typ.abbr ='AUT-P04'"
               @commentary_aut04 = RequestsAdministration::Commentary.find_by_sql(lv_sql)
               if @commentary_aut04.empty?
                   r= 4  #NO existe, entonces, se requiere la autorización 4
               else
                   r = 999  #"Ya esta liberado Autorizado
               end
           end
        end
     end
     r
   end


# Obtener las autorizaciones que puede (tiene acceso) realizar según el rol
# pm_tipo: (E) Edición, (V) Visualización
def get_rol_aut(pm_tipo)
  

  autoriza = Array.new

  role = Administration::UserSession.find.record.attributes['role']
  # -- PERMISO DE EDICION (CAMBIOS) PRESUPUESTO
  if pm_tipo == "E"
    # -- ADMINISTRADOR
    if role=='ADMIN'  
       autoriza << { :aut => 1 }
       autoriza << { :aut => 2 }
       #autoriza << { :aut => 3 }
       autoriza << { :aut => 4 }
    end

    # -- COORDINADOR
    if role=='COORD'
       autoriza << { :aut => 1 }
       autoriza << { :aut => 2 }
       autoriza << { :aut => 4 }
    end

    # -- ANALISTA PRESUPUESTADOR
    if role=='APRE'       
       autoriza << { :aut => 1 }
    end

    # -- SECRETARIO TECNICO
    if role == 'SECTEC'       
       autoriza << { :aut => 3 }       
    end
  end

  # -- PERMISO DE VISUALIZACION DE PRESUPUESTO
  if pm_tipo == "V"
    # -- ADMINISTRADOR
    if role=='ADMIN'
       autoriza << { :aut => 1 }
       autoriza << { :aut => 2 }
       autoriza << { :aut => 3 }
       autoriza << { :aut => 4 }
    end

    # -- COORDINADOR
    if role=='COORD'
       autoriza << { :aut => 1 }
       autoriza << { :aut => 2 }
       autoriza << { :aut => 3 }
       autoriza << { :aut => 4 }
    end

    # -- ANALISTA PRESUPUESTADOR
    if role=='APRE'
       autoriza << { :aut => 1 }
       autoriza << { :aut => 2 }
       autoriza << { :aut => 3 }
       autoriza << { :aut => 4 }
    end

    # -- SECRETARIO TECNICO
    if role == 'SECTEC'
       autoriza << { :aut => 3 }
       autoriza << { :aut => 4 }
    end
  end
  #---
  autoriza
end

# Devuelve Verdadero si tiene permiso para Editar (E) o Visualizar (V), o falso si no tiene permiso
# requets_id => ID del presupuesto
# 1 = Primer autorización (Analista)
# 2 = Segunda autorización (Coordinador) --Pre-liberación
# 3 = Tercer Autorización del Secretario tecnico responsable de la dependencia
# 3 = Cuarta autorización (Coordinador) -- Liberado (Autorización final) Coordinador
   def get_num_aut_req(request_id, pm_tipo)

     @budgets_budget = Budgets::Budget.find(:first,:conditions => {:support_request_id => request_id})
     if not @budgets_budget
       false
       return
     end
     # pm_tipo = 'E' Edicion, 'V' Visualización
     autoriza = get_rol_aut(pm_tipo)  #autoriza es un array con las autorizaciones a las que tiene acceso
     r = 1

     
     lv_aux ="SELECT com.* FROM request_commentaries com, catalogs_comment_types typ, budgets_budgets bud
                   WHERE com.comment_type_id = typ.id
                     AND com.budget_id =bud.id
                     AND bud.support_request_id =".concat(request_id.to_s)
     lv_sql = lv_aux + " AND typ.abbr ='AUT-P01'"

     @commentary_aut01 = RequestsAdministration::Commentary.find_by_sql(lv_sql)
     if not @commentary_aut01.empty?
        r = 2
        lv_sql = lv_aux + " AND typ.abbr ='AUT-P02'"
        @commentary_aut02 = RequestsAdministration::Commentary.find_by_sql(lv_sql)
        if not @commentary_aut02.empty?
           r = 3
           lv_sql = lv_aux + " AND typ.abbr ='AUT-P03'"
           @commentary_aut03 = RequestsAdministration::Commentary.find_by_sql(lv_sql)
           if not @commentary_aut03.empty?
               lv_sql = lv_aux + " AND typ.abbr ='AUT-P04'"
               @commentary_aut04 = RequestsAdministration::Commentary.find_by_sql(lv_sql)
               if @commentary_aut04.empty?
                   r= 4  #NO existe, entonces, se requiere la autorización 4
               else
                   r = 999  #"Ya esta liberado Autorizado
               end
           end
        end
     end
   

     # R tiene el No. de autorización actual
     exito = false
     if r == 999
        if pm_tipo=="E" #Edicion
          exito = false
        else  
          exito = true
        end
        
     else
        for p in 0..autoriza.length-1
          if autoriza[p][:aut]==r
             exito = true
          end
        end
     end
     exito
   end

   def get_list_budget
     user_ubication_id= Administration::UserSession.find.record.attributes['ubication_id']
     user_id = Administration::UserSession.find.record.attributes['id']
     role = Administration::UserSession.find.record.attributes['role']
     if role == 'ADMIN'
       @budgets_budgets = Budgets::Budget.all.paginate :page =>params[:page],:per_page=>22, :order => 'created_at DESC'
       return @budgets_budgets
     else
       lv_sql ="SELECT * FROM budgets_budgets
                WHERE user_id =".concat(user_id.to_s)+
               "  OR support_request_id IN (SELECT DISTINCT support_request_id
                               FROM request_delegations
                              WHERE user_id = ".concat(user_id.to_s) +")
                 ORDER BY created_at DESC "
     end

     @budgets_budgets=Budgets::Budget.find_by_sql(lv_sql).paginate :page =>params[:page],:per_page=>22, :order => 'created_at DESC'
     return  @budgets_budgets

   end
   
end
