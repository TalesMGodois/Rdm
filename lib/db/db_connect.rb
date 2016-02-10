require 'roo'

module DB



	SELIC	= "S"
	PIB 	= "P"
	IPCA 	= "I"
	DOLAR  	= "D"

	TABLE = Hash.new()

	
	pib_ot = Hash.new()
	ipca_ot = Hash.new()
	dolar_ot = Hash.new()

	# table 		= Roo::Spreadsheet.open("../sheets/Dados_Tabelados.xlsx")
	table = Roo::Spreadsheet.open("lib/db/sheets/Dados_Tabelados.xlsx")
	
	TABLE[:selic] = table.sheet('Selic_Otimizado')
	TABLE[:pib] 	= table.sheet('Pib_Otimizado')
	TABLE[:ipca] 	= table.sheet('IPCA_Otimizado')
	TABLE[:dolar] = table.sheet('Dolar_Otimizado')

	def self.simplify
		selic_ot = Hash.new()
		aux = 2015 - 2007
		aux = aux + 1
		months = TABLE[:selic].column(1)
		for i in 1 .. aux
			data = TABLE[:selic].column(i + 1)
			year = data.shift()

			data.each do |item|

				selic_ot["#{months[i]}-#{year}"] = item
			end
		end

		puts selic_ot

	end

	def modify(ant,prox)
		return 1 if([ant,prox].max == prox) 
		return 0 if([ant,prox].max == ant) 
	end
	
end


DB::simplify()