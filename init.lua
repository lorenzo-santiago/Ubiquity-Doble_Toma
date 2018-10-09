--init.lua

gpio.mode(4, gpio.OUTPUT)
gpio.write(4, gpio.HIGH)
cnt = 0

print("Iniciando Toma")

tmr.alarm(1, 1000, 1, function()
if wifi.sta.getip()== nil then
    cnt = cnt + 1
	print("(" .. cnt .. ") Esperando IP...")
    if cnt == 10 then
        tmr.stop(1)
        dofile("setwifi.lua")
    end
else
    print("hola")
	tmr.stop(1)
    dofile("onoff.lua")
end
end)
