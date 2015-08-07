# proinfo-debian-config

Coleção de arquivos de configuração dos multiterminais para Debian GNU/Linux em computadores do ProInfo.

Para obter uma cópia deste repositório, execute o seguinte comando:
```
git clone http://gitlab.se-pmmc.com.br/pte/proinfo-debian-config.git
```

# Instruções de instalação e configuração

Todas as informações necessárias estão disponíveis em nosso [wiki](http://gitlab.se-pmmc.com.br/pte/proinfo-debian-config/wikis/home).

# Números obtidos com o Debian 8 configurado para 3 terminais

* Testes realizados em um computador do pregão 71/2010 no dia 03/07/2015. Os resultados podem variar de um computador para outro.
* Tempo médio de boot (da tela do GRUB à tela de login): **18 segundos**
* Para as tabelas abaixo, a margem de erro foi estimada em ±5MB.

|Consumo de memória RAM em uma instalação normal para 3 terminais | LXDE  | XFCE  | MATE  |
|-----------------------------------------------------------------|-------|-------|-------|
| Antes do login                                                  | 218MB | 223MB | 205MB |
| Imediatamente após o login nos 3 terminais                      | 431MB | 403MB | 385MB |
| Acréscimo médio por login                                       |  71MB |  60MB |  60MB |

|Consumo de memória RAM em uma instalação mínima para 3 terminais | LXDE  | XFCE  | MATE  |
|-----------------------------------------------------------------|-------|-------|-------|
| Antes do login                                                  | 172MB | 172MB | 171MB |
| Imediatamente após o login nos 3 terminais                      | 293MB | 286MB | 303MB |
| Acréscimo médio por login                                       |  40MB |  38MB |  44MB |