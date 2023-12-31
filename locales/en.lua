local Translations = {
    error = {
        no_value = 'Value must be higher then 0',
        no_black_money = 'You don\'t have that much blackmoney on you!',
    },
    info = {
        washed_money = 'Washed $%{price} black money and got $%{netprice}s back!',
    },
    menu = {
        wash_money_header = 'Wash Black Money',
        wash_money_text = 'Wash black money and receive legal money',
        washing_header = 'Washing Menu',
        how_much = "- How much ? -",
        change = "Change",
        close = 'Close',
    },
    target = {
        open = 'Open Menu',
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
