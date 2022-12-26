class ConnectStylesToBeersAndCleanUp < ActiveRecord::Migration[7.0]
  def change
    Beer.all.map(&:old_style).uniq.map{ |style| Style.create!(name: style) }

    Beer.all.each do |beer|
      beer.style = Style.where(name: beer.old_style).first
      beer.save
    end

    remove_column :beers, :old_style
  end
end
