local Translations = {
    notify = {
        ["fliping"] = "Fliping vehicle",
        ["title"] = "ReduX Scripts",
        ["desc"] = "Fliped vehicle!",
        ["fail"] = "Vehicle flip failed!"
    }
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end