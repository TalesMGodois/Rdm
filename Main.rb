require 'roo'
require 'googlecharts'


Plan = Roo::Spreadsheet.open("sheets/Selic.xlsx")

Plan.sheet('planilha').column(1)[1]

puts Gchart.bar( :data => [[1,2,4,67,100,41,234],[45,23,67,12,67,300, 250]], 
            :title => 'SD Ruby Fu level', 
            :legend => ['matt','patrick'], 
            :bar_colors => 'ff0000,00ff00')

