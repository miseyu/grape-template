task routes_for_grape: :environment do
  doc = File.open File.join(Rails.root, "doc/all.md"), 'w'
  [*GeneralAPI.routes].each do |route|
    info = route.instance_variable_get :@options
    description = info[:description] || ''
    method = info[:method]
    doc.puts "### #{description}"
    doc.puts '```'
    doc.puts "#{method} #{info[:path]}"
    doc.puts '```'
    doc.puts '```'
    doc.puts "parameter: #{info[:params].to_yaml}"
    doc.puts '```'
    doc.puts ""
  end
  doc.close
end
