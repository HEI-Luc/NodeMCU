

uart.setup(0,115200,8,0,1,1)
--uart.setup(0,921600,8,0,1,0)
tmr.delay(200)


print("Baud Rate set to 115200 by DDrmx")

print("\nNodeMCU Started")


local exefile= "Connect"
local luaFile = {exefile..".lua"}
local lcFile = {exefile..".lc"}
for i, f in ipairs(luaFile) do
    if file.open(f) then
		file.close()
		for j, g in ipairs(lcFile) do
			if file.open(g) then
			  file.close()
			  file.remove(g)
			end
		end
      print("Compile File:"..f)
      node.compile(f)
      print("Remove File:"..f)
      file.remove(f)
	  
	  --dofile(exefile..".lc")		
    end
 end
 
 

exefile= "Webserver"
luaFile = {exefile..".lua"}
lcFile = {exefile..".lc"}
for i, f in ipairs(luaFile) do
    if file.open(f) then
		file.close()
		for j, g in ipairs(lcFile) do
			if file.open(g) then
			  file.close()
			  file.remove(g)
			end
		end
      print("Compile File:"..f)
      node.compile(f)
      print("Remove File:"..f)
      file.remove(f)
	  
	  --dofile(exefile..".lc")
    end
 end
 
luaFile = nil;
lcFile = nil;

	gpio.mode(1, gpio.INPUT, gpio.PULLUP)
	if gpio.read(1) == 1 then

		if file.open("Connect.lc") then
			 file.close()
			--print("Connect.lc non voulu")
			dofile("Connect.lc")
		else
			print("Connect.lc not exist")
		end
	end

exefile=nil;

print("Fin de l'init")
collectgarbage()
