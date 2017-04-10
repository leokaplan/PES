--[[
  Leonardo KAPLAN - 1212509
--]]


opcoes = {}

--[[
  checa se um dado termo é valido, isto é se esta em caixa alta
  entrada: termo(string)
  saida: booleano
--]]
function CA(text)
  if string.upper(text) == text then
    return true
  else
    return false
  end
end

--[[
  retira termos de uma descricao, termos sao palavras em caixa alta
  entrada: termo(string)
  saida: lista de termos(strings) em caixa alta
--]]
function dependencias(text)
  local words = {}
  for word in text:gmatch("%w+") do 
    if CA(word) then
      table.insert(words, word) 
    end
  end
  return words
end

--[[
  checa se todos os termos em uma lista de termos sao validos, isto é se estao em caixa alta
  entrada: tabela de termos(strings)
  saida: booleano
--]]
function valido(t)
  for k,v in pairs(t) do
    if termos[v] == nil then
      return false
    end
  end
  return true
end

--[[
  pergunta um termo p usuario e exibe suas dependencias e sua definicao
  entrada: deps e termos (globais)
  saida: deps e termos (globais)
--]]
opcoes.inserir = function()
  print("digite um novo termo em caixa alta")
  local termo = io.read()
  if CA(termo) then
    print("digite a definicao de "..termo)
    local desc = io.read()
    local dep = dependencias(desc)
    if valido(dep) then
      termos[termo] = desc
      deps[termo] = dep
    else
      print("nao valido, defina:",unpack(dep))
    end
  else
    return inserir()
  end
end

--[[
  pergunta um termo p usuario e exibe suas dependencias e sua definicao
  entrada: deps e termos (globais)
  saida: deps e termos (globais)

--]]
opcoes.consultar = function()
  print("digite um termo")
  local termo = io.read()
  print(">",termo, termos[termo])
  if #deps[termo] == 0 then
    print(termo,"não depende de nada")
  else
    print(termo,"depende de ", unpack(deps[termo]))
  end
end

--[[
  lista todos os termos do lexico, suas dependencias e sua definicao
  entrada: deps e termos (globais)
  saida: deps e termos (globais)
--]]
opcoes.listar = function ()
  for k,v in pairs(termos) do
    print(k.." : ", unpack(deps[k]))
    print("",termos[k])
  end
end



-------------------------------------------------
option = nil
termos = {}
deps= {}

print("digite s para carregar o lexico basico, qlqr outra coisa p começar vazio")
option = io.read()
if option == 's' then
  termos.NOME = "um VALOR unico"
  termos.VALOR = "um dado dentre os tipos de dados"
  termos.ATRIBUTO = "tem pelo menos um NOME e um VALOR, e é utilizado para armazenar informação"
  termos.INDIVIDUO = "são os componentes básicos de uma ontologia. descritos atraves de um conjunto de ATRIBUTO"
  termos.CLASSES = "são grupos abstratos, conjuntos ou coleções de OBJETO. Eles podem conter INDIVIDUO, outras classes, ou uma combinação de ambos."
  termos.RELACIONAMENTOS = "é um ATRIBUTO cujo VALOR é outro OBJETO na ontologia"
  termos.OBJETO = "um INDIVIDUO ou uma CLASSE"
  
  for k,v in pairs(termos) do
    deps[k] = dependencias(v)
  end
end


option = nil
while option ~= 0 do
  print("comandos:")
  for k,v in pairs(opcoes) do
    print("* "..k)
  end
  option = io.read()
  if opcoes[option] then
    opcoes[option]()
  else
    print(option, "nao valido!")
  end
end


