	print("")
	print("Start Webserver")

    function start_init()  

		for pinoche = 0, 8, 1 do -- start end inc

			gpio.mode(pinoche, gpio.OUTPUT);  
			gpio.write(pinoche,gpio.HIGH); 
		end

	D0_state=0;
	D1_state=0;
	D2_state=0;
	D3_state=0;
	D4_state=0;
	D5_state=0;
	D6_state=0;
	D7_state=0;
	D8_state=0;
	
	end

	sendFileContents = function(conn, filename)      
		if file.open(filename, "r") then
			--conn:send(responseHeader("200 OK","text/html"));          
			repeat           
				local line=file.readline()           
				if line then               
					conn:send(line);          
				end 
				
			until not line           
			
			file.close();      
		else
			conn:send(responseHeader("404 Not Found","text/html"));          
			conn:send("Page not found");              
		end  
	end 

	function responseHeader (code, type)      
		return "HTTP/1.1 " .. code .. "\r\nConnection: close\r\nServer: nunu-Luaweb\r\nContent-Type: " .. 
		type .. "\r\n\r\n";   
	end 

	function httpserver()      
    start_init();   
    srv=net.createServer(net.TCP)       
    srv:listen(80,function(conn)         
		conn:on("receive",function(conn,request)           
		conn:send(responseHeader("200 OK","text/html"));  

		
		if string.find(request,"gpio=0") then              
			if D0_state==0 then
				D0_state=1; gpio.write(0,gpio.LOW); preset0_on="checked=\"checked\"";
			else                  
				D0_state=0; gpio.write(0,gpio.HIGH); preset0_on="";		   
			end          
		elseif string.find(request,"gpio=1") then              
			if D1_state==0 then                  
			   D1_state=1;gpio.write(1,gpio.LOW); preset1_on="checked=\"checked\"";            
			else  
			   D1_state=0;gpio.write(1,gpio.HIGH); preset1_on="";
			end       
		elseif string.find(request,"gpio=2") then              
			if D2_state==0 then                  
			   D2_state=1;gpio.write(2,gpio.LOW); preset2_on="checked=\"checked\"";              
			else  
			   D2_state=0;gpio.write(2,gpio.HIGH); preset2_on="";
			end       
		elseif string.find(request,"gpio=3") then              
			if D3_state==0 then                  
			   D3_state=1;gpio.write(3,gpio.LOW); preset3_on="checked=\"checked\"";              
			else  
			   D3_state=0;gpio.write(3,gpio.HIGH); preset3_on="";
			end       
		elseif string.find(request,"gpio=4") then              
			if D4_state==0 then                  
			   D4_state=1;gpio.write(4,gpio.LOW); preset4_on="checked=\"checked\"";           
			else  
			   D4_state=0;gpio.write(4,gpio.HIGH); preset4_on="";
			end       
		elseif string.find(request,"gpio=5") then              
			if D5_state==0 then                  
			   D5_state=1;gpio.write(5,gpio.LOW); preset5_on="checked=\"checked\"";             
			else  
			   D5_state=0;gpio.write(5,gpio.HIGH); preset5_on="";
			end       
		elseif string.find(request,"gpio=6") then              
			if D6_state==0 then                  
			   D6_state=1;gpio.write(6,gpio.LOW); preset6_on="checked=\"checked\"";           
			else  
			   D6_state=0;gpio.write(6,gpio.HIGH); preset6_on="";
			end       
		elseif string.find(request,"gpio=7") then              
			if D7_state==0 then                  
			   D7_state=1;gpio.write(7,gpio.LOW);  preset7_on="checked=\"checked\"";            
			else  
			   D7_state=0;gpio.write(7,gpio.HIGH); preset7_on="";
			end       
		elseif string.find(request,"gpio=8") then              
			if D8_state==0 then                  
			   D8_state=1; gpio.write(8,gpio.LOW); preset8_on="checked=\"checked\"";   
			else  
			   D8_state=0; gpio.write(8,gpio.HIGH); preset8_on="";
			end       
		else   
		
			if D0_state==0 then                  
				preset0_on="";   
			else               
				preset0_on="checked=\"checked\"";
			end    
			
			if D1_state==0 then                  
				preset1_on="";              
			else                  
				preset1_on="checked=\"checked\"";              
			end 
			
			if D2_state==0 then                  
				preset2_on="";              
			else                 
				preset2_on="checked=\"checked\"";              
			end 
			
			if D3_state==0 then                  
				preset3_on="";              
			else                  
				preset3_on="checked=\"checked\"";              
			end 
			
			if D4_state==0 then                  
				preset4_on="";              
			else
				preset4_on="checked=\"checked\"";              
			end 
			
			if D5_state==0 then                  
				preset5_on="";              
			else                 
				preset5_on="checked=\"checked\"";              
			end 
			
			if D6_state==0 then                  
				preset6_on="";    
			else
				preset6_on="checked=\"checked\"";              
			end 
			
			if D7_state==0 then                  
				preset7_on="";              
			else                 
				preset7_on="checked=\"checked\"";              
			end 
			
			if D8_state==0 then                  
				preset8_on="";              
			else                  
				preset8_on="checked=\"checked\"";              
			end 

			sendFileContents(conn,"header.htm");
			
			local secondSend = "<div>"
			
			--conn:send("<div>");
			
				for id = 0, 8, 1 do -- start end inc
					
					if(id==0) then
						preset_on=preset0_on
					elseif(id==1) then
						preset_on=preset1_on
					elseif(id==2) then
						preset_on=preset2_on
					elseif(id==3) then
						preset_on=preset3_on
					elseif(id==4) then
						preset_on=preset4_on
					elseif(id==5) then
						preset_on=preset5_on
					elseif(id==6) then
						preset_on=preset6_on
					elseif(id==7) then
						preset_on=preset7_on
					elseif(id==8) then
						preset_on=preset8_on
					end
					
					secondSend=secondSend.."<div><input type=\"checkbox\" id=\"checkbox"..id.."\" name=\"checkbox"..id.."\" class=\"switch\" onclick=\"loadXMLDoc("..id..")\" "..preset_on.." /> <label for=\"checkbox"..id.."\">D"..id.."</label></div>"
					
					
					
					--conn:send("<div><input type=\"checkbox\" id=\"checkbox"..id.."\" name=\"checkbox"..id.."\" class=\"switch\"");
					--conn:send("onclick=\"loadXMLDoc("..id..")\" "..preset_on.." />");
					--conn:send("<label for=\"checkbox"..id.."\">D"..id.."</label></div>"); 
				
				end
			
			secondSend=secondSend.."</div>"
			--conn:send("</div>");

			conn:send(secondSend);
			
			
		end          
			print(request);
		end)         
			conn:on("sent",function(conn)           
						conn:close();           
						conn = nil;              
						end)      
		end)  
    end    

    httpserver()