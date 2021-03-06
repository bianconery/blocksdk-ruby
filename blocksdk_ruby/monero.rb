require_relative 'base'

class Monero < Base
	def getBlockChain(request = {})
		return request("GET","/xmr/block")
	end
	
	def getBlock(request = {})
		request["rawtx"].to_s.empty? ? request['rawtx'] = false : request['rawtx']
		request["offset"].to_s.empty? ? request['offset'] = 0 : request["offset"]
		request["limit"].to_s.empty? ? request['limit'] = 10 : request["limit"]

		return request("GET","/xmr/block/" +    (request['block']).to_s+ "",{
			"rawtx" => request['rawtx'],
			"offset" => request['offset'],
			"limit" => request['limit']
		})
	end

	def getMemPool(request = {})
		request["rawtx"].to_s.empty? ? request['rawtx'] = false : request['rawtx']
		request["offset"].to_s.empty? ? request['offset'] = 0 : request["offset"]
		request["limit"].to_s.empty? ? request['limit'] = 10 : request["limit"]
		
		return request("GET","/xmr/mempool",{
			"rawtx" => request['rawtx'],
			"offset" => request['offset'],
			"limit" => request['limit']
		})
	end
	
	def listAddress(request = {})
		request["offset"].to_s.empty? ? request['offset'] = 0 : request["offset"]
		request["limit"].to_s.empty? ? request['limit'] = 10 : request["limit"]
		
		return request("GET","/xmr/address",{
			"offset" => request['offset'],
			"limit" => request['limit']
		})
	end

	def createAddress(request = {})
		request["name"].to_s.empty? ? request['name'] = nil : request["name"]	
		return request("POST","/xmr/address",{
			"name" => request['name']
		})
	end
	
	def getAddressInfo(request = {})
		request["offset"].to_s.empty? ? request['offset'] = 0 : request["offset"]
		request["limit"].to_s.empty? ? request['limit'] = 10 : request["limit"]
		
		return request("GET","/xmr/address/" + (request['address_id']).to_s+ "",{
			"offset" => request['offset'],
			"limit" => request['limit'],
			"private_spend_key" => request['private_spend_key'],
		})
	end
	
	def getAddressBalance(request = {})
		return request("GET","/xmr/address/" + (request['address_id']).to_s+ "/balance",{
			"private_spend_key" => request['private_spend_key'],
		})
	end

	def loadAddress(request = {})
		return request("POST","/xmr/address/" + (request['address_id']).to_s+ "/load",{
			"private_spend_key" => request['private_spend_key'],
			"password" => request['password']
		})
	end

	def unLoadAddress(request = {})		
		return request("POST","/xmr/address/" + (request['address_id']).to_s+ "/unload")
	end

	def sendToAddress(request = {})

		if request["kbfee"].to_s.empty?
			blockChain = getBlockChain()
			request['kbfee'] = blockChain['medium_fee_per_kb']
		end

		request["private_spend_key"].to_s.empty? ? request['private_spend_key'] = nil : request["private_spend_key"]
		request["password"].to_s.empty? ? request['password'] = nil : request["password"]
		
		return request("POST","/xmr/address/" +    (request['address_id']).to_s+ "/sendtoaddress",{
			"address" => request['address'],
			"amount" => request['amount'],
			"private_spend_key" => request['private_spend_key'],
			"password" => request['password'],
			"kbfee" => request['kbfee']
		})
	end

	def getTransaction(request = {})		
		return request("GET","/xmr/transaction/" + (request['hash']).to_s+ "")
	end
end