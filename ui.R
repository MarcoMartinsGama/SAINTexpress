library(shiny)


fluidPage(
  # Application title
  titlePanel("SAINTexpress"),
  useShinyjs(),
  
  sidebarLayout(
    sidebarPanel(
      width = 5,
      HTML("<trong>What Operating System are you using ?</strong>"),
      tags$div(style = "margin-bottom: 20px;",
        checkboxInput("linux", "Linux", value = FALSE),
        checkboxInput("windows", "Windows", value = FALSE),
        checkboxInput("mac", "Mac", value = FALSE)),
      
      HTML("<strong>SAINTexpress Method:</strong>"),
      checkboxInput("spc", "Spectral count", value = TRUE),
      checkboxInput("int", "Intensity", value = FALSE),
      
      conditionalPanel(
        condition = "input.int == true && input.spc == true",
        checkboxInput("merge_spc_int", "Merge msspc_list.txt and msint_list.txt?", value = TRUE)),
      actionButton("generate_list","Start SAINTexpress")
    ),
    
    mainPanel(
      width = 5,
      conditionalPanel(
        condition = "input.spc == true",
        fileInput("msspc_interactions", "Input msspc_saint_interactions.txt", accept = c("text/plain", ".txt")),
        fileInput("msspc_preys", "Input msspc_saint_preys.txt", accept = c("text/plain", ".txt")),
        fileInput("msspc_bait", "Input msspc_saint_baits.txt", accept = c("text/plain", ".txt"))
      ),
      conditionalPanel(
        condition = "input.int == true",
        fileInput("msint_interactions", "Input msint_saint_interactions.txt", accept = c("text/plain", ".txt")),
        fileInput("msint_preys", "Input msint_saint_preys.txt", accept = c("text/plain", ".txt")),
        fileInput("msint_bait", "Input msint_saint_baits.txt", accept = c("text/plain", ".txt"))
      )
    )
  )
)