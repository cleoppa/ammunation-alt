-- github.com/cleoppa & github.com/desterofficial
-- "SilahTürü" = { silahID, Mermi Miktarı, Fiyat}
local silahTurleri = {
	["pistol"]	= { 22, 17, 425 },
	["deagle"]	= { 24, 17, 525 },
	["silenced"]		= { 23, 17, 600 }, --Ic baron için.
	["uzi"] 	= { 28, 25, 575 },
	["tec-9"]	= { 32, 25, 630 },
	["mp5"] 	= { 29, 25, 725 },
	["shotgun"]		= { 25, 10, 850 },
	["ak-47"]	= { 30, 25, 1100 },
	["m4"]		= { 31, 25, 1250 },
	
}
colShape = createColSphere( 1424.9951171875, -1292.7138671875, 13.556790351868, 3)
setElementData(colShape, "mermiYeri", true)
function mermiBilgi(thePlayer, cmd)
	for index, colShape in ipairs(getElementsByType("colshape", resourceRoot)) do
		if getElementData(colShape, "mermiYeri") then
			if isElementWithinColShape(thePlayer, colShape) then
				local playerTeam = getPlayerTeam(thePlayer)
				local playerTeamType = getElementData(playerTeam, "type")
				if not playerTeam then
					outputChatBox(">> #ffffffHerhangi bir oluşumda bulunmuyorsunuz.", thePlayer, 0, 255, 0, true)
					return false
				end
				if playerTeamType == 1 or playerTeamType == 0 then
					outputChatBox("#FF0000======================================", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFPISTOL:   17 Mermi (1 Şarjör) [425$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFDEAGLE:  17 Mermi (1 Şarjör) [525$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFSİLENCED:  17 Mermi (1 Şarjör) [600$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFUZI:           25 Mermi (1 Şarjör) [575$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFTEC-9:      25 Mermi (1 Şarjör) [630$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFMP5:         25 Mermi (1 Şarjör) [725$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFSHOTGUN:         10 Mermi (1 Şarjör) [850$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFAK47:       25 Mermi (1 Şarjör) [1100$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFM4:           25 Mermi (1 Şarjör) [1250$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000======================================", thePlayer, 255, 255, 255, true)
					outputChatBox("#66FF33/mermial #FFFFFFyazarak satin almayi gerceklestirebilirsiniz.", thePlayer, 255, 255, 255, true)
					outputChatBox("#66FF33/mermial #FFFFFFpistol 2 || yazarak 2 şarjor pistol mermisi alabilirsiniz.", thePlayer, 255, 255, 255, true)
				else
					outputChatBox(" >> #ffffffİl-Legal bir oluşuma dahil olmadığınız için işlem iptal edildi.", thePlayer, 0, 255, 0, true)
				end
			end
		end
	end
end
addCommandHandler("mermi", mermiBilgi)

function mermiAl(thePlayer, cmd, silahTuru, sarjorMiktari)
	for index, colShape in ipairs(getElementsByType("colshape", resourceRoot)) do
		if getElementData(colShape, "mermiYeri") then
			if isElementWithinColShape(thePlayer, colShape) then
				local playerTeam = getPlayerTeam(thePlayer)
				local playerTeamType = getElementData(playerTeam, "type")
				if playerTeamType == 1 or playerTeamType == 0 then
					if not silahTuru or not silahTurleri[string.lower(silahTuru)] or not sarjorMiktari then
						outputChatBox(">> #ffffffSÖZDİZİMİ: /" .. cmd .. " [Mermi Türü] [Şarjör Miktarı]", thePlayer, 0, 25, 0, true)
						return false
					end
					if silahTurleri[string.lower(silahTuru)] then
						local playerWeapons = getPedWeapons(thePlayer)
						if not playerWeapons[1] then
							outputChatBox(">> #ffffffBu mermiyi satın almak için uygun silahınız yok.", thePlayer, 0, 255, 0, true)
							return false
						end
						
						for index, weaponID in ipairs(playerWeapons) do
							if weaponID == silahTurleri[string.lower(silahTuru)][1] then
								local toplamFiyat = silahTurleri[string.lower(silahTuru)][3] * sarjorMiktari
								outputChatBox(">> #ffffffToplam tutar: " .. toplamFiyat .. "$ Satışı onaylamak için /mermionayla, iptal etmek için /mermiiptal yazın!", thePlayer, 0, 0, 255, true)
								setElementData(thePlayer, "mermi:tutar", toplamFiyat)
								setElementData(thePlayer, "mermi:sarjorMiktari", sarjorMiktari)
								setElementData(thePlayer, "mermi:silahTuru", silahTurleri[string.lower(silahTuru)][1])
								setElementData(thePlayer, "mermi:mermiMiktari", silahTurleri[string.lower(silahTuru)][2])
								return true
							else
								outputChatBox(">> #ffffffBu mermiyi satın almak için uygun silahınız yok.", thePlayer, 255, 0, 0, true)
								return false
							end
						end
					end
				end
			end
		end
	end	
end
addCommandHandler("mermial", mermiAl)

function mermiOnayla(thePlayer, cmd)
	local mermiTutari = getElementData(thePlayer, "mermi:tutar")
	if mermiTutari then
		if exports.global:hasMoney(thePlayer, mermiTutari) then
			local sarjorMiktari = getElementData(thePlayer, "mermi:sarjorMiktari")
			local silahTuru = getElementData(thePlayer, "mermi:silahTuru")
			local mermiMiktari = getElementData(thePlayer, "mermi:mermiMiktari")
			
			exports.global:takeMoney(thePlayer, mermiTutari)
			for i = 1, sarjorMiktari do
				give, error = exports.global:giveItem(thePlayer, 116, silahTuru..":"..mermiMiktari..":Silah Mermisi "..getWeaponNameFromID(silahTuru))
			end
			setElementData(thePlayer, "mermi:tutar", false)
			setElementData(thePlayer, "mermi:sarjorMiktari", false)
			setElementData(thePlayer, "mermi:silahTuru", false)
			outputChatBox(">> #ffffffSatış başarıyla gerçekleştirildi! " .. sarjorMiktari .. " Şarjör (" .. mermiMiktari .. ") için toplam " .. mermiTutari .. "Dolar ücret ödediniz!", thePlayer, 0, 255, 0, true)
		else
			outputChatBox(">> #ffffffYeterli paranız yok!", thePlayer, 255, 0, 0, true)
		end
	end
end
addCommandHandler("mermionayla", mermiOnayla)

function mermiIptal(thePlayer, cmd)
	local mermiTutari = getElementData(thePlayer, "mermi:tutar")
	if mermiTutari then
		setElementData(thePlayer, "mermi:tutar", false)
		setElementData(thePlayer, "mermi:sarjorMiktari", false)
		setElementData(thePlayer, "mermi:silahTuru", false)
		outputChatBox(">> #ffffffMermi alma işlemini iptal ettiniz, tekrar almak istiyorsanız. /mermial", thePlayer, 0, 255, 0, true)
	end
end
addCommandHandler("mermiiptal", mermiIptal)

-- cleoppa
function getPedWeapons(ped)
    local weaponList = {}
 
    for i = 0, 12 do
        local weaponID = getPedWeapon(ped, i)
 
        if weaponID ~= 0 then
            table.insert(weaponList, weaponID)
        end
    end
   
    return weaponList
end
