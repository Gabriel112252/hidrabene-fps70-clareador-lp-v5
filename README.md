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

São **dois gatilhos**, porque desktop e mobile saem de jeitos diferentes:

| Onde | Gatilho | O que acontece |
|---|---|---|
| Desktop | Mouse sai pelo topo (rumo à aba / barra de endereço) | A oferta abre como **painel sobre a LP**, com X pra fechar. A URL não muda. |
| Desktop + mobile | Botão **voltar** | Vai pra `oferta-kit-clareador.html` (página inteira). |

O critério: mouse saindo é sinal **fraco** — a pessoa pode só estar trocando de aba, e
arrancar ela da página irrita. O voltar é sinal **forte**, aí o redirect vale e ainda te dá
um pageview limpo pra medir. No celular não existe "tirar o mouse", então lá só o voltar
dispara (guardado por `matchMedia('(hover: hover) and (pointer: fine)')`, senão o overlay
abriria sozinho no primeiro toque).

O overlay carrega a **própria** `oferta-kit-clareador.html` num iframe com `?embed=1`
(que esconde o rodapé e abre espaço pro X). Ou seja: existe **uma cópia só** da copy da
oferta — mexeu na página, mexeu no overlay junto.

Três detalhes no JS do voltar que fazem funcionar de verdade:

1. **Arma só depois do primeiro gesto** do usuário (touch/scroll/click/tecla). O Chrome
   tem uma *history manipulation intervention* que PULA entradas de histórico criadas
   sem interação — é a razão nº 1 de back redirect não funcionar no Android.
2. **Empilha uma entrada só.** Reempilhar a cada `popstate` prende a pessoa na página.
3. **`location.replace`** (não `.href`) ao mandar pra oferta: a página de oferta não vira
   outra entrada no histórico, então o "voltar" de lá deixa a pessoa ir embora.

**Sem trava de sessão:** a oferta reaparece toda vez que a pessoa esboça sair. Tem só uma
carência de 4s no carregamento (pra não abordar quem acabou de chegar) e um respiro de 1,5s
depois de fechar — sem esse respiro, quem clica no X com o mouse ainda lá em cima reabre o
painel no primeiro tremido e acha que o botão de fechar está quebrado.

Repetir sempre é seguro **porque o redirect usa `location.replace`**: a entrada da LP é
consumida, então quem cai na oferta sai no "voltar" seguinte em vez de ricochetear de volta
pra LP. Testado: LP → voltar → oferta → voltar → sai pra página anterior à LP. Se algum dia
alguém trocar isso por `location.href`, a trava de sessão tem que voltar junto, senão vira
laço e a pessoa não consegue mais sair.

### Armadilha da UTMify (não desfaça isso)

O script da UTMify reescreve `src`/`href` da página. Um `<iframe>` vazio no HTML recebia
dela a URL da **própria LP** — e o painel abria mostrando a landing page em vez da oferta.
Por isso o iframe é criado por JS na hora de abrir, e o HTML tem só um `<div id="br-slot">`.

Outra: a classe que mostra o overlay entra depois de um **reflow síncrono**, não de um
`requestAnimationFrame`. rAF é suspenso em aba fora de foco, e o painel ficava sem a classe
— aberto no papel, invisível na tela.

## Como testar

O gatilho do voltar arma **depois do primeiro gesto**: abra, **role a página**, e só então
volte. O exit intent do mouse só vale a partir de 4s de página.

Os dois **repetem sempre** — não precisa de aba anônima pra testar de novo.

## Pendências

- Os R$ 69,90 vêm do **cupom `PROMOKIT53`** aplicado sobre o Kit Clareador (token
  `6AZG3M30PU`, R$ 99,90 cheio) — está no `CHECKOUT_URL` de `oferta-kit-clareador.html`.
  Se mexerem nesse cupom lá na Yampi, o preço da página para de bater com o do checkout.
- Os 3 vídeos em `assets/video/br/` são **provisórios** (vieram da LP do Kit Clareador).
  Trocar pelos 3 do mockup: manchas de sol, melasma, 50+ anos.
