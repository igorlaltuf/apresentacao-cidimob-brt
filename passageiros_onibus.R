library(readxl)
library(tidyverse)
library(gganimate)
library(plotly)

dados <- read_excel('dados/1736.xls', range = 'A7:P45') %>% 
  na.omit() %>% 
  janitor::clean_names() %>% 
  select(1,6,7,8,9,15,16) %>% 
  mutate_all(as.integer)


p <- ggplot(data=dados, aes(x = ano, y = total/1000000)) +
  geom_line(color='blue', linetype = 'dashed') +
  geom_point(color='black') +
  ylab('Total de passageiros transportados (em milhões)')+
  scale_x_continuous(name = 'Ano', # dado do eixo x
                     limits = c(2000, 2020),  # valor m?ximo e m?nimo do eixo
                     n.breaks = 5) +
  theme(panel.background = element_blank())

p <- ggplotly(p) # transforma em plotly para depois exportar via saveWidget

htmlwidgets::saveWidget(as_widget(p), "img/grafico_passageiros.html")


# salto em 2005 com as gratuidades