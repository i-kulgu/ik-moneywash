local Translations = {
    error = {
        no_value = 'Waarde moet hoger zijn dan 0 zijn',
        no_black_money = 'Je hebt niet zoveel zwart geld bij je!',
    },
    info = {
        washed_money = 'Gewassen $%{price} zwart geld en kreeg $%{netprice}s terug!',
    },
    menu = {
        wash_money_header = 'Was Zwart Geld',
        wash_money_text = 'Was zwart geld en ontvang legaal geld',
        washing_header = 'Menu wassen',
        how_much = "- Hoeveel kost het? -",
        change = "Verander",
        close = 'Sluiten',
    },
    target = {
        open = 'Open Menu',
    },
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end