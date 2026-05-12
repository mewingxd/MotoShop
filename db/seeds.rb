# Admin user
User.find_or_create_by!(email: "admin@motoshop.com") do |u|
  u.password = "admin123"
  u.name = "Administrador"
  u.role = "admin"
end

# Ventas user
User.find_or_create_by!(email: "ventas@motoshop.com") do |u|
  u.password = "ventas123"
  u.name = "Vendedor"
  u.role = "ventas"
end

# Categories
%w[Aceites Frenos Motor Electricidad Llantas Filtros Cadenas Bujías].each do |name|
  Category.find_or_create_by!(name: name)
end

# Sample mechanic
Mechanic.find_or_create_by!(full_name: "Juan Pérez") do |m|
  m.salary = 8000
  m.active = true
end

puts "Seeds cargados correctamente"
