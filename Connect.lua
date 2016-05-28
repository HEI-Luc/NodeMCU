	print("")
	print("Start Connect")

	function TryConnect()

		if(wifi.sta.status() ~= 5 )then
			
			wifi.sta.disconnect()

			
			print("TryConnect")

			wifi.setmode(wifi.STATION) 
			
			--print(SSID)
			--print (PWD)
	
			wifi.sta.config(SSID,PWD)
			wifi.sta.connect()

			ip=wifi.sta.getip()

			if wifi.sta.status() ~= 5 then
			
				--print("")
				print("\tEchec de connexion")
				
				tmr.alarm(5, 1000, tmr.ALARM_SINGLE, TryConnect)
			else
			
				print("Connection reussi")
				
				tmr.alarm(5, 1000, tmr.ALARM_SINGLE, TryConnect)
				
				if srv then
				  srv:close()
				end
			end
			
		else
		
			ip=wifi.sta.getip()
			
			print("Connexion etablie l'ip est : "..ip)
			
			if file.open("Webserver.lc") then
				 file.close()
				--print("Webserver.lc non voulu")
				dofile("Webserver.lc")
			else
				print("Webserver.lc not exist")
			end
			
			SSID = nil
			PWD = nil
		end
	end
	
	function InitWifi()
	
		print("InitWifi")
		
		if file.open("Config_Wifi.txt", "r") then
			str = file.readline()
			file.close()
			SSID = string.sub(str,1,string.find(str, ":")-1)
			PWD = string.sub(str,string.find(str, ":")+1,string.find(str, ";")-1) 
			
			str = nil
			
			print(SSID)
			print (PWD)
			
			TryConnect()
		else
			print("Config_Wifi.txt not exist")
		end
					
	end
	
	InitWifi()
	
	