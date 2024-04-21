local Translations = {
    notify = {
        ["fliping"] = "Sõiduki ümberpööramine",
        ["title"] = "ReduX Scripts",
        ["desc"] = "Sõiduk ümberpööratud!",
        ["fail"] = "Ebaõnnestusid!"
    }
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end