local Translations = {
    error = {
        no_value = 'Değer 0\'dan büyük olmalıdır',
        no_black_money = 'Üzerinde o kadar kara para yok!',
    },
    info = {
        washed_money = '$%{price} Kara parayı yıkadı ve $%{netprice}\'ı geri aldı!',
    },
    menu = {
        wash_money_header = 'Kara Para Yıka',
        wash_money_text = 'Kara parayı yıkayın ve yasal parayı alın',
        washing_header = 'Yıkama',
        how_much = "- Ne Kadar ? -",
        change = "Değiştir",
        close = 'Kapat',
    },
    target = {
        open = 'Menüyü aç',
    },
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end