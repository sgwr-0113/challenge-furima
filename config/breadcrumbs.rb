crumb :root do
  link "トップページ", root_path
  # parent :hoge
  # 一番上の階層は特にparentの記載は不要
end

crumb :new_item do
  link "新規出品画面", new_item_path
  parent :root
end

crumb :show_item do |item|
  if item.order
    link "商品名: #{item.name}(売り切れ)", item_path(item)
  else
    link "商品名: #{item.name}", item_path(item)
  end
  parent :root
end

crumb :edit_item do |item|
  link "商品編集画面"
  parent :show_item, item
end

crumb :order do |item|
  link "商品購入画面"
  parent :show_item, item
end

crumb :purchase_with_card do |item|
  link "商品購入画面(登録カードで決済)"
  parent :show_item, item
end

crumb :index_card do
  link "カード確認画面", cards_path
  parent :root
end

crumb :new_card do
  link "カード登録画面"
  parent :index_card
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).