require 'roo'

module DB

	SELIC	= "S"
	# PIB 	= "P"
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
		selic = self.getArray(TABLE[:selic])
		ipca  = self.getArray(TABLE[:ipca])
		dolar = self.getArray(TABLE[:dolar])

		dados = Object.new
		dados[:selic] = selic
		dados[:ipca] = ipca
		dados[:ipca] = ipca

		self.traduct(dadps)


	end

	def self.getArray(sheet)
		return sheet

		if sheet.class == Roo::Excelx 
			selic_ot = Hash.new()

			months = sheet.column(1)

			years = sheet.row(1)
			aux = years.size() - 1

			for i in 1..aux
				data = TABLE[:selic].column(i +1)
				data.shift()
				j = 0
				data.each do |item|
					j = j+1
					selic_ot["#{months[j]}-#{years[i]}"] = item
				end
			end

			return self.each_modify(selic_ot)
		else
			return "not a excel file"
		end
	end

	def self.modify(ant,prox)
		return 1 if([ant,prox].max == prox) 
		return 0 if([ant,prox].max == ant) 
	end

	def self.each_modify(hash)
		hash_simple = Hash.new
		aux = 0

		hash.each do |k,v|
			hash_simple[k] =self.modify(aux,v)
			aux = v 			
		end
		return hash_simple
	end

	def self.traduct(dados)
		selic = dados.selic
		

	end

	
end


DB::simplify()