
# Question 5
# function to randomly configure the Little Enigma plugboard
plugboard <- function(){

  matrix( sample(letters), nrow = 13, ncol = 2)

}

plugboard <- plugboard()


# Question 6

message <- 'hello friend I am on a subamarine How are you stop'

encode <- function(message){
  # put everything lowercase
  message <- tolower(message)

  # swap letters according to plugboard
  for(i in 1:nrow(plugboard)){
    message <- gsub(pattern = plugboard[i,1], replacement = toupper(plugboard[i,2]), message)
  }

  # take a second pass, replacing letters in column 2 with the letters in column 1
  for(i in 1:nrow(plugboard)){
    message <- gsub(pattern = plugboard[i,2], replacement = toupper(plugboard[i,1]), message)
  }

  message
}

encode(message)
encode(encode(message))

message |> encode() |> encode() |> encode() |> encode()
