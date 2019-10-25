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

-- UUID generation fixed by zorg: https://love2d.org/forums/viewtopic.php?f=5&t=87517
function analytics.createUUID()
    math.randomseed(os.time())
    local uuid = {}
    local char = {[0] = '0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'}
    for i = 1, 32+4 do
        uuid[i] = char[math.random( 0x0 , 0xF )]
    end
    uuid[9], uuid[14], uuid[19], uuid[24] = '-', '-', '-', '-'
    uuid[15] = '4'
    uuid[20] = char[math.random( 0x8 , 0xB )]
    uuid = table.concat(uuid)
    return uuid
end

return analytics