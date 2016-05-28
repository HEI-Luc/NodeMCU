	print("")
	print("Start Connect")


	
	
	function TryConnect()

			if(wifi.sta.status() ~= 5 )then
			
			print("TryConnect")

			wifi.setmode(wifi.STATION) 
			wifi.sta.config(SSID,PWD)
			wifi.sta.connect()

			ip=wifi.sta.getip()

			if wifi.sta.status() ~= 5 then
			
				--print("")
				print("\tEchec de connexion")
				print("\t"..ip)
				
			tmr.alarm(5, 1000, tmr.ALARM_SINGLE, TryConnect)
			else
			
				print("Connection reussi")
				--print(ip)
				
				tmr.alarm(5, 1000, tmr.ALARM_SINGLE, TryConnect)
				
				if srv then
				  srv:close()
				end
			end
			
		else
			print("Connexion etablie l'ip est : ")
			print(ip)
			
			SSID = nil
			PWD = nil
		end
	end
	
	function InitWifi()
	
		print("InitWifi")
	
		file.open("Config_Wifi.txt", "r")
		str = file.readline()
		file.close()
		SSID = string.sub(str,1,string.find(str, ":")-1)
		PWD = string.sub(str,string.find(str, ":")+1,string.len(str)) 
		
		str = nil
		
		TryConnect()
		
	end
	
	InitWifi()
	
	