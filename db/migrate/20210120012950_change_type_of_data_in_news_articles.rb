class ChangeTypeOfDataInNewsArticles < ActiveRecord::Migration[6.1]
  def up
  change_column :news_articles, :published_at, :datetime
end

def down
  change_column :news_articles, :published_at, :date
end
end
