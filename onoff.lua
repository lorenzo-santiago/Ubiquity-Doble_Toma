--onoff.lua
print("onoff")
Relay1 = 4
Relay2 = 5
gpio.mode(Relay1, gpio.OUTPUT)
gpio.write(Relay1, gpio.LOW);
gpio.mode(Relay2, gpio.OUTPUT)
gpio.write(Relay2, gpio.LOW);

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
		
		buf = buf.."<head><meta name='viewport' content='width=200px, initial-scale=1.0'/>"
        buf = buf.."<style>body  { background-image: url('GIVE IMAGE URL');background-repeat: no-repeat;background-position: 0px 150px;}</style>"
        buf = buf.."<font face='verdana'><h1> ESP8266 Wifi Power Switch </h1>";
        buf = buf.."<p> Relay 1 PIN 4 <a href=\"?pin=ON1\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF1\"><button>OFF</button></a></p>";
        buf = buf.."<p> Relay 2 PIN 5 <a href=\"?pin=ON2\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF2\"><button>OFF</button></a></p>";
		local _on,_off = "",""
        if(_GET.pin == "ON1")then
              gpio.write(Relay1, gpio.HIGH);
        elseif(_GET.pin == "OFF1")then
              gpio.write(Relay1, gpio.LOW);
        elseif(_GET.pin == "ON2")then
              gpio.write(Relay2, gpio.HIGH);
        elseif(_GET.pin == "OFF2")then
              gpio.write(Relay2, gpio.LOW);
		        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
