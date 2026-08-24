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
