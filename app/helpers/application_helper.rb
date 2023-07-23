module ApplicationHelper
  include Pagy::Frontend #Podkluczenie "Pagy"    
  
  def pagination(obj)# Pagy "gem pagy" razbiw na stranicy Podkluchenie
    raw(pagy_bootstrap_nav(obj)) if obj.pages > 1
  end
  #//////////////////////////////////////////////////////////////////////////////////////

  # Chtoby ssylki byli cwetnymi : dosen`t work
  def nav_tab(title, url, options = {})
        current_page = options.delete :current_page
    
        css_class = current_page == title ? 'text-secondary' : 'text-white'
    
        options[:class] = if options[:class]
                            options[:class] + ' ' + css_class
                          else
                            css_class
                          end
        
        link_to title, url, options
      end
                   # podkluchenie "Menu" _menu.html.erb
      #def currently_at(current_page = '')
      #  render partial: 'shared/menu', locals: {current_page: current_page}
      #end
          # Wywodim nadpis w okne
      def full_title(page_title = "")
        base_title = "Nenashev"
        if page_title.present?
          "#{page_title} | #{base_title}"
        else
          base_title
        end
    end       
    
    
end
