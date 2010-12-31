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

   # Obtener el número de autorización del presupuesto siguiente
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
           if not @commentary_aut03.empty
                r = 999  #"Ya esta liberado Autorizado
           end
        end
     end
     r
   end

end
