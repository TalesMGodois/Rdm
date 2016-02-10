require 'roo'
require 'googlecharts'


Plan = Roo::Spreadsheet.open("lib/db/sheets/Selic.xlsx")

puts Plan.sheet('planilha').column('A')

# puts Gchart.bar( :data => [[1,2,4,67,100,41,234],[45,23,67,12,67,300, 250]], 
#             :title => 'SD Ruby Fu level', 
#             :legend => ['matt','patrick'], 
#             :bar_colors => 'ff0000,00ff00')

