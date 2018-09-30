class StaticPagesController < ApplicationController

  def home
  end

  def help
  end

  def autocomplete_food_menu
    term = params[:term]
    # APIで指定された名前から一覧を取得する

    suggestions = {}
    
    agent = Mechanize.new
    page = agent.get(URL + URI.encode(term))
    tr_list = page.search('div.result table tr')
    tr_list.each do |tr|
      alt_text = nil
      calorie = nil
      
      tr.search('td').each.with_index do |td, index|
        if index == 0
          alt_text = td.at('div.thumb40 a img').get_attribute(:alt)
        elsif index == 3
          calorie_text = td.at('div').inner_text
          calorie = calorie_text.to_i if calorie_text.present?
        end
      end
        
      if alt_text.present? # and calorie.present?
        suggestions[alt_text] = calorie
      end
    end
    render json: suggestions
  end  

  def new
    @static_pages = StaticPage.new
    respond_with(@static_pages)
  end

end