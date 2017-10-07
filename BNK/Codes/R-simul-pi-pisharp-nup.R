setwd("~/Documents/Programs/Projects/BNK/")
phi = 0.75
epsilon = 10
beta = 0.99
pi = seq(-0.02,0.02,by=0.001)
pisharp = (((1+pi)^(1-epsilon)-phi)/(1-phi))^(1/(1-epsilon))-1
nup=((1-phi) * ((1+pi)/(1+pisharp))^(epsilon))/(1-phi * (1+pi)^(epsilon))

library(ggplot2)
library(Rmisc)
df1 <- data.frame(x=rep(pi,2),
                  y=c(pisharp,pi),
                  class=c(rep("pisharp",length(pisharp)),rep("pi",length(pi)))
                    ) 
p1=NULL;
p1 <- ggplot(data=df1,
       aes(x=x,y=y,color=class))
p1 <- p1 + geom_point();
p1 <- p1 + labs(size= "Nitrogen",
          x = "pi",
          y = "pisharp",
          title = "pisharp vs pi")
p1 <- p1 + theme(legend.position = 'bottom')
#p1

df2 <- data.frame(x=pi,
                  y=nup,
                  class=c(rep("pi",length(pi)),rep("nup",length(nup)))) 
p2=NULL;
p2 <- ggplot(data=df2,
            aes(x=x,y=y))
p2 <- p2 + geom_point();
p2 <- p2 + labs(size= "Nitrogen",
              x = "pi",
              y = "nup",
              title = "nup vs pi")
#p2

temp = ((1-phi*beta*(1+pi)^epsilon)/(1-phi*beta*(1+pi)^(epsilon-1)))*((1+pisharp)/(1+pi))
mc = temp * (epsilon-1)/epsilon
df3 <- data.frame(x=pi,
                  y=mc,
                  class=c(rep("pi",length(pi)),rep("mc",length(mc)))) 
p3=NULL;
p3 <- ggplot(data=df3,
             aes(x=x,y=y))
p3 <- p3 + geom_point();
p3 <- p3 + labs(size= "Nitrogen",
                x = "pi",
                y = "marginal cost",
                title = "mc vs pi")
inversemkupstatic=(epsilon-1)/epsilon
p3 <- p3 + geom_hline(yintercept=inversemkupstatic)
#p3
multiplot(p1,p2,p3,cols=3)
#ggsave("plots.pdf")

distortion=(1/nup) / mc
df4 <- data.frame(x=pi,
                  y=distortion,
                  class=c(rep("pi",length(pi)),rep("distortion",length(distortion)))) 
df2 <- data.frame(x=pi,
                  y=nup,
                  class=c(rep("pi",length(pi)),rep("nup",length(nup)))) 
p4=NULL;
p4 <- ggplot(data=df4,
             aes(x=x,y=y))
p4 <- p4 + geom_point();
p4 <- p4 + labs(size= "Nitrogen",
                x = "pi",
                y = "mpn-mc",
                title = "distortion vs pi")
#p2



phi = seq(0.001,0.999,by=0.001)
beta = 0.99
slope = (1-phi) * (1-phi * beta)/phi
plot(slope ~ phi, type="l")
