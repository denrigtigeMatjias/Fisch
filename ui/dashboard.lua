-- https://denrigtigematjias.github.io/
local url = "https://render-mzyi.onrender.com/increment/Fisch"

local response = request({
    Url = url,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json",
    },
    Body = game:GetService("HttpService"):JSONEncode({
        game = "Fisch"
    })
})

if response.Success then
    print("Increment successful! Response:", response.Body)
else
    print("Failed to increment count. Error:", response.StatusCode)
end
