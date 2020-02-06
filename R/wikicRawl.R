
html<-"https://en.wikipedia.org/wiki/List_of_physicists"
rl<-httr::GET("https://en.wikipedia.org/wiki/List_of_physicists")
xl<-xml2::read_html(html)
xml2::write_xml(xl,"test.xml")

test<-xml2::xml_find_all(xl,".//li")

a<-lapply(test,function(x) xml_find_all(x,".//a"))
where<-a[[2]] %>% xml_attrs() %>% unlist %>% .[1]

html2<-paste0("https://en.wikipedia.org",where)
xl2<-xml2::read_html(html2)
test<-xml2::xml_find_all(xl2,".//table")

test2<-xml2::xml_text(test)
pediarr::pediasearch("List of Physicists")
pediarr::pediaextract("List of Physicists")
a<-pediarr::pediaextract("List of Physicists")
a$V1
a$V2
a<-pediarr::pediafulltest("List of Physicists")
a<-pediarr::pediafulltext("List of Physicists")
a
a<-pediarr::pediafulltext("https://en.wikipedia.org/wiki/List_of_physicists")
a<-pediarr::pediafulltext("List_of_physicists",lang = "en")
b<-str_split(a,"\n")
b[[1]][10]
