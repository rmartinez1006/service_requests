WillPaginate::ViewHelpers.pagination_options[:previous_label] = 'Anterior'
WillPaginate::ViewHelpers.pagination_options[:next_label] = 'Siguiente'

#  WillPaginate::ViewHelpers.pagination_options[:previous_label] = 'Previous page'

#By putting this into “config/initializers/will_paginate.rb” (or simply environment.rb in older versions of Rails) you can easily translate link texts to previous and next pages, as well as override some other defaults to your liking.


#@@pagination_options =
#default options that can be overridden on the global level
#    {
#      :class          => 'pagination',
#      :previous_label => '&laquo; Previous',
#      :next_label     => 'Next &raquo;',
#      :inner_window   => 4, # links around the current page
#      :outer_window   => 1, # links around beginning and end
#      :separator      => ' ', # single space is friendly to spiders and non-graphic browsers
#      :param_name     => :page,
#      :params         => nil,
#      :renderer       => 'WillPaginate::LinkRenderer',
#      :page_links     => true,
#      :container      => true
#    }


