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
def get_rol_aut
  r = nil

  autoriza = Array.new

  role = Administration::UserSession.find.record.attributes['role']
  if role=='APRE'
    r = {'aut01'=> 1}   # No. de autorización que tiene que realizar
    autoriza << { :aut => 1 }
  end
  if role=='COORD'
    r={'aut02'=> 2, 'aut04'=> 4}
    autoriza << { :aut => 2 }
    autoriza << { :aut => 4 }
  end
  if role == 'SECTEC'
    r={'aut03'=> 3} # No. de autorización que tiene que realizar
    autoriza << { :aut => 3 }
  end
  if role=='ADMIN'
    r={'aut01'=> 1,'aut02'=> 2, 'aut03'=> 3,'aut04'=> 4}
    autoriza << { :aut => 1 }
    autoriza << { :aut => 2 }
    autoriza << { :aut => 3 }
    autoriza << { :aut => 4 }
  end
  autoriza
end

# Obtener el número de autorización siguiente del presupuesto (Por ID de Solicitud)
# budget_id => ID del presupuesto
# 1 = Primer autorización (Analista)
# 2 = Segunda autorización (Coordinador) --Pre-liberación
# 3 = Tercer Autorización del Secretario tecnico responsable de la dependencia
# 3 = Cuarta autorización (Coordinador) -- Liberado (Autorización final) Coordinador
   def get_num_aut_req(request_id)

     autoriza = get_rol_aut
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
        exito = true
     else
        for p in 0..autoriza.length-1
          if autoriza[p][:aut]==r
             exito = true
          end
        end
     end
     exito
   end
   
end
