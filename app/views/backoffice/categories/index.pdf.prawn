prawn_document do |pdf|
  pdf.text('Listando categorias')
  pdf.move_down 20
  pdf.table @categories.collect{|c| [c.id, c.description]}
end
