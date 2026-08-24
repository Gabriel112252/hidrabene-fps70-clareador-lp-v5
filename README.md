# Protetor Solar Facial FPS 70 Clareador — Landing Page (v5 · back redirect)

Variante de teste da landing page do **Protetor Solar Facial FPS 70 Clareador** da Hidrabene Derma.

Base: cópia exata da página que está rodando no tráfego
(`https://protetor-clareador-fps-70.hidrabene.com.br/`, commit `b3d1485` do repo
`hidrabene-fps70-clareador-lp`). Única variável do teste: **back redirect**.

> ⚠️ **Conteúdo confidencial.** Página não indexada em buscadores (`noindex`). Compartilhe o link apenas internamente.

## Ver online
Hospedado via GitHub Pages — link na seção **Deployments / Pages** do repositório.

## Rodar local
Arquivo estático: basta abrir `index.html` no navegador.

## Estrutura
- `index.html` — página completa (HTML + CSS + JS inline)
- `assets/` — imagens, vídeos (`video/`), logo e selos da marca (`brand/`)

## Diferenças para a página em produção
- **Back redirect** — copy e estrutura a definir.

## Checkout
Links Yampi por kit em `CHECKOUT_URLS` (1/2/3 unidades), com `withUtms()` repassando as
UTMs da página pro link. Idênticos aos de produção — domínio `hidrabene.pay.yampi.com.br`.

> Nota: o working tree local do `lp-fps70` tem uma alteração **nunca deployada** trocando
> esse domínio por `seguro.hidrabene.com.br`. Não foi trazida pra cá de propósito, pra
> que o back redirect seja a única variável do teste.

## Back redirect

Quem tenta sair pelo **botão voltar** cai em `oferta-kit-clareador.html` (Kit Clareador
Facial por R$ 69,90) em vez de sumir. O gatilho é o botão voltar — não "exit intent" de
mouse, que no celular não existe. Funciona em Android, iOS e desktop.

Três detalhes no JS de `index.html` que fazem funcionar de verdade:

1. **Arma só depois do primeiro gesto** do usuário (touch/scroll/click/tecla). O Chrome
   tem uma *history manipulation intervention* que PULA entradas de histórico criadas
   sem interação — é a razão nº 1 de back redirect não funcionar no Android.
2. **Empilha uma entrada só.** Reempilhar a cada `popstate` prende a pessoa na página.
3. **`location.replace`** (não `.href`) ao mandar pra oferta: a página de oferta não vira
   outra entrada no histórico, então o "voltar" de lá deixa a pessoa ir embora.

Dispara **uma vez por sessão** (`sessionStorage: hb_br_fps70`). As UTMs da LP são
repassadas pra página de oferta.

## Pendências

- `CHECKOUT_URL` em `oferta-kit-clareador.html` está **vazia** — precisa do link Yampi do
  Kit Clareador com o preço de **R$ 69,90** (o link do kit na LP normal é R$ 99,90).
- Os 3 vídeos em `assets/video/br/` são **provisórios** (vieram da LP do Kit Clareador).
  Trocar pelos 3 do mockup: manchas de sol, melasma, 50+ anos.
