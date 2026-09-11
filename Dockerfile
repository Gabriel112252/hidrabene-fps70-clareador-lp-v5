FROM nginx:alpine

COPY . /usr/share/nginx/html

# Hidrabene Insight / Uniclick — Protetor Clareador FPS 70
RUN sed -i 's#</head>#  <script src="https://insight.hidrabene.com.br/uniclick.js?attribution=lastpaid\&cookiedomain=hidrabene.com.br\&cookieduration=90\&defaultcampaignid=6aa2f755818faec5cb6874a2\&regviewonce=false\&rtkcidurl=true\&script_id=6aa2f88e1044a350a10f243d"></script>\n</head>#' /usr/share/nginx/html/index.html \
 && sed -i 's#https://hidrabene.pay.yampi.com.br/r/FQH20J70UC#https://insight.hidrabene.com.br/click/1#g' /usr/share/nginx/html/index.html \
 && sed -i 's#https://hidrabene.pay.yampi.com.br/r/524DBLU40W#https://insight.hidrabene.com.br/click/2#g' /usr/share/nginx/html/index.html \
 && sed -i 's#https://hidrabene.pay.yampi.com.br/r/KIAU1RFFXS#https://insight.hidrabene.com.br/click/3#g' /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]