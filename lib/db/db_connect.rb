require 'roo'
require 'matrix'

module DB

	SELIC	= "S"
	IPCA 	= "I"
	DOLAR  	= "D"

	
	
	pib_ot = Hash.new()
	ipca_ot = Hash.new()
	dolar_ot = Hash.new()

	

	def self.simplify

		table = Roo::Spreadsheet.open("lib/db/sheets/Dados_Tabelados.xlsx")

		data_table = Hash.new()

		data_table[:selic]   = table.sheet('Selic_Otimizado')
		selic = self.getArray(data_table[:selic])

		data_table[:ipca] 	= table.sheet('IPCA_Otimizado')
		ipca  = self.getArray(data_table[:ipca])
		
		data_table[:dolar]   = table.sheet('Dolar_Otimizado')
		dolar = self.getArray(data_table[:dolar])

		data = Hash.new

		data[:selic] = selic
		data[:ipca] = ipca
		data[:dolar] = dolar

		self.traduct(data)


	end

	def self.getArray(sheet)

		if sheet.class == Roo::Excelx 
			hs = Hash.new()

			months = sheet.column(1)

			years = sheet.row(1)
			aux = years.size() - 1

			for i in 1..aux
				data = sheet.column(i +1)
				data.shift()
				j = 0
				data.each do |item|
					j = j+1
					hs["#{months[j]}-#{years[i]}"] = item
				end
			end

			# return hs
			return self.each_modify(hs)
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
			hash_simple[k] =self.modify(aux,v)#
			aux = v 			
		end

		return hash_simple
	end

	def self.traduct(data)
		selic = data[:selic]
		ipca = data[:ipca]
		dolar = data[:dolar]

		final_table = Hash.new()

		selic.keys.each do |k|
			final_table[k] = Array.new()
		end

		selic.each do |k,v|
			final_table[k].push("S") if v == 1

		end

		ipca.each do |k,v|
			final_table[k].push("I") if v == 1

		end

		dolar.each do |k,v|
			final_table[k].push("D") if v == 1

		end

		aux = 0
		final_table.each do |k,v|
			if v.size ==0
				aux = aux +1
			end
		end
		return final_table
		# puts final_table
	end
	
end


DB::simplify()
