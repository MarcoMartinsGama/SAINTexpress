library(shiny)

if (!requireNamespace("shinyjs", quietly = TRUE))install.packages("shinyjs")
library(shinyjs)

function(input, output, session) {
  
  observeEvent(input$linux, {
    if (input$linux) {
      updateCheckboxInput(session, "windows", value = FALSE)
      updateCheckboxInput(session, "mac", value = FALSE)
    }
  })
  
  observeEvent(input$windows, {
    if (input$windows) {
      updateCheckboxInput(session, "linux", value = FALSE)
      updateCheckboxInput(session, "mac", value = FALSE)
    }
  })
  
  observeEvent(input$mac, {
    if (input$mac) {
      updateCheckboxInput(session, "linux", value = FALSE)
      updateCheckboxInput(session, "windows", value = FALSE)
    }
  })
  
  observeEvent(input$generate_list, {
    output$text <- renderText("Working... Please Wait.")
    delay(50, {
      if (input$windows) {
        if (input$spc) {
          req(input$msspc_interactions, input$msspc_preys, input$msspc_bait)
          cmd_saint <- paste("../Windows/SAINTexpress-spc.exe",
                             input$msspc_interactions$datapath,
                             input$msspc_preys$datapath,
                             input$msspc_bait$datapath)
          print(cmd_saint)
          system(cmd_saint)
          file.rename("list.txt", "msspc_list.txt")
          output$msspc_download <- downloadHandler(
            filename = function() { "msspc_list.txt" },
            content = function(file) { file.copy("msspc_list.txt", file) }
          )
        }
        if (input$int) {
          req(input$msint_interactions, input$msint_preys, input$msint_bait)
          cmd_saint <- paste("../Windows/SAINTexpress-int.exe",
                             input$msint_interactions$datapath,
                             input$msint_preys$datapath,
                             input$msint_bait$datapath)
          system(cmd_saint)
          file.rename("list.txt", "msint_list.txt")
          output$msint_download <- downloadHandler(
            filename = function() { "msint_list.txt" },
            content = function(file) { file.copy("msint_list.txt", file) }
          )
        }
        if (input$merge_spc_int) {
          merge <- merge(
            read.table(file = "msspc_list.txt", header = T, sep = "\t", stringsAsFactors = F),
            read.table(file = "msint_list.txt", header = T, sep = "\t", stringsAsFactors = F),
            by = c("Bait", "Prey"), all = T
          )
          write.table(merge, "merged_list.txt", row.names = F, sep = "\t", quote = F)
          output$merged_download <- downloadHandler(
            filename = function() { "merged_list.txt" },
            content = function(file) { file.copy("merged_list.txt", file) }
          )
        }
        output$text <- renderText("Done.")
      }
      if (input$linux) {
        if (input$spc) {
          req(input$msspc_interactions, input$msspc_preys, input$msspc_bait)
          cmd_saint <- paste("../Linux/SAINTexpress-spc",
                             input$msspc_interactions$datapath,
                             input$msspc_preys$datapath,
                             input$msspc_bait$datapath)
          system(cmd_saint)
          file.rename("list.txt", "msspc_list.txt")
          output$msspc_download <- downloadHandler(
            filename = function() { "msspc_list.txt" },
            content = function(file) { file.copy("msspc_list.txt", file) }
          )
        }
        if (input$int) {
          req(input$msint_interactions, input$msint_preys, input$msint_bait)
          cmd_saint <- paste("../Linux/SAINTexpress-int",
                             input$msint_interactions$datapath,
                             input$msint_preys$datapath,
                             input$msint_bait$datapath)
          system(cmd_saint)
          file.rename("list.txt", "msint_list.txt")
          output$msint_download <- downloadHandler(
            filename = function() { "msint_list.txt" },
            content = function(file) { file.copy("msint_list.txt", file) }
          )
        }
        if (input$merge_spc_int) {
          merge <- merge(
            read.table(file = "msspc_list.txt", header = T, sep = "\t", stringsAsFactors = F),
            read.table(file = "msint_list.txt", header = T, sep = "\t", stringsAsFactors = F),
            by = c("Bait", "Prey"), all = T
          )
          write.table(merge, "merged_list.txt", row.names = F, sep = "\t", quote = F)
          output$merged_download <- downloadHandler(
            filename = function() { "merged_list.txt" },
            content = function(file) { file.copy("merged_list.txt", file) }
          )
        }
        output$text <- renderText("Done.")
      }
      if (input$mac) {
        if (input$spc) {
          req(input$msspc_interactions, input$msspc_preys, input$msspc_bait)
          cmd_saint <- paste("../Linux/SAINTexpress-spc",
                             input$msspc_interactions$datapath,
                             input$msspc_preys$datapath,
                             input$msspc_bait$datapath)
          system(cmd_saint)
          file.rename("list.txt", "msspc_list.txt")
          output$msspc_download <- downloadHandler(
            filename = function() { "msspc_list.txt" },
            content = function(file) { file.copy("msspc_list.txt", file) }
          )
        }
        if (input$int) {
          req(input$msint_interactions, input$msint_preys, input$msint_bait)
          cmd_saint <- paste("../Linux/SAINTexpress-int",
                             input$msint_interactions$datapath,
                             input$msint_preys$datapath,
                             input$msint_bait$datapath)
          system(cmd_saint)
          file.rename("list.txt", "msint_list.txt")
          output$msint_download <- downloadHandler(
            filename = function() { "msint_list.txt" },
            content = function(file) { file.copy("msint_list.txt", file) }
          )
        }
        if (input$merge_spc_int) {
          merge <- merge(
            read.table(file = "msspc_list.txt", header = T, sep = "\t", stringsAsFactors = F),
            read.table(file = "msint_list.txt", header = T, sep = "\t", stringsAsFactors = F),
            by = c("Bait", "Prey"), all = T
          )
          write.table(merge, "merged_list.txt", row.names = F, sep = "\t", quote = F)
          output$merged_download <- downloadHandler(
            filename = function() { "merged_list.txt" },
            content = function(file) { file.copy("merged_list.txt", file) }
          )
        }
        output$text <- renderText("Done.")
      }
      
      output$download_buttons <- renderUI({
        buttons <- tagList()
        if (input$spc) buttons <- tagAppendChild(buttons, downloadButton("msspc_download", "Download msspc_list.txt"))
        if (input$int) buttons <- tagAppendChild(buttons, downloadButton("msint_download", "Download msint_list.txt"))
        if (input$merge_spc_int) buttons <- tagAppendChild(buttons, downloadButton("merged_download", "Download merged_list.txt"))
        buttons
      })
    })
  })
}