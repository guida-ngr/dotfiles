leia com atenção
ricing de: arch linux + i3wm + polybar + picom

da uma olhada nas config do i3, la vc pode mudar as keybinds como voce quiser

!!!! ainda falta muito a ser feito, principalmente nas configurações do picom, no que envolve janelas mais bonitas e robustas

como vc usa void então muda o .bshrc
la tem uma função foda se vc usa nitrogen, vc seta o wallpaper so com o nome dele (sem .jpg .jpge etc), ele procura na pasta ~/Downloads
exemplo: wp nomedewallpaper

o comando vai procurar esse nome em ~/Downloads e n precisa usar o .png .jpg etc
POLYBAR
alterar monitor
modulo wifi voce tem que configurar para voce, DA ATENÇÃO P ISSO
modulo weather precisa fazer cadastro e pegar uma chave da API (nao gostou usa outro jeito, tipo wttr.ini)
auto start da polybar nao ta funcionando (nao sei o porque)
PARA FUNCIONAR o modulo weather alem da chave api vc precisa baixar "jq" e "bc"
