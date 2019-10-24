local http = require('socket.http')

local analytics={}

function analytics.view(path, title)
    local url=analytics.getBaseURL()..'&dp='..path
    if title ~=nil then
        url=url..'&dt='..title
    end
    http.request(url)
end

function analytics.event(category, action, label, value)
    local url=analytics.getBaseURL()..'&t=event&ec='..category..'&ea='..action..'&el='..label
    if value ~=nil then
        url=url..'&ev='..value
    end
    http.request(url)
end

function analytics.transaction(id, revenue, shipping, tax, affiliation)
    local url=analytics.getBaseURL()..'&t=transaction&ti='..id..'&tr='..revenue
    if affiliation ~=nil then
        url=url..'&ta='..affiliation
    end
    if shipping ~=nil then
        url=url..'&ts='..shipping
    end
    if tax ~=nil then
        url=url..'&tt='..tax
    end
    http.request(url)
end

function analytics.transactionItem(transaction_id, name, sku, price, quantity, category)
    local url=analytics.getBaseURL()..'&t=item&ti='..transaction_id..'&in='..name
    if sku ~=nil then
        url=url..'&ic='..sku
    end
    if price ~=nil then
        url=url..'&ip='..price
    end
    if quantity ~=nil then
        url=url..'&iq='..quantity
    end
    if category ~=nil then
        url=url..'&iv='..category
    end
    http.request(url)
end

function analytics.getBaseURL()
    if analytics.id==nil then
        print('Analytics ID (UA-XXXXX-Y) needs to be set.')
    end
    if analytics.client_id==nil then
        print('ClientID needs to be (re)set.')
    end
    url='http://www.google-analytics.com/collect?v=1&tid='..analytics.id..'&cid='..analytics.client_id
    return url
end

function analytics.setID(id)
    analytics.id=id
end

function analytics.resetClientID(client_id)
    if client_id==nil then
        client_id=analytics.createUUID()
    end
    analytics.client_id=client_id
end

function analytics.createUUID()
    math.randomseed(os.time())
    local uuid = ""
    local chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    for i = 1, 30 do
        local l = math.random(1, #chars)
        uuid = uuid .. string.sub(chars, l, l)
    end
    return uuid
end

return analytics