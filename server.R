library(shiny)
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
 
  
  observeEvent(input$generate_list,{
  if(input$windows){
    if(input$spc){
      req(input$msspc_interactions,input$msspc_preys,input$msspc_bait)
      cmd_saint <- paste("Windows\\SAINTexpress-spc.exe",
                         input$msspc_interactions$datapath,
                         input$msspc_preys$datapath,
                         input$msspc_bait$datapath)
      system(cmd_saint)
      file.rename("list.txt", "msspc_list.txt")}
    if(input$int){
      req(input$msint_interactions,input$msint_preys,input$msint_bait)
      cmd_saint <- paste("Windows\\SAINTexpress-int.exe",
                         input$msint_interactions$datapath,
                         input$msint_preys$datapath,
                         input$msint_bait$datapath)
      system(cmd_saint)
      file.rename("list.txt", "msint_list.txt")
    } 
    if (input$merge_spc_int){
      
     merge<- merge(
        read.table(file= "msspc_list.txt", header = T, sep = "\t", stringsAsFactors = F),
        read.table(file = "msint_list.txt", header = T, sep = "\t", stringsAsFactors = F), 
        by = c("Bait", "Prey"), all = T)
     write.table(merge, 
                 "merged_list.txt", row.names = F, sep = "\t", quote = F)
    } } 
    
    
    if(input$linux){
      if(input$spc){
        req(input$msspc_interactions,input$msspc_preys,input$msspc_bait)
        
        cmd_saint <- paste("Linux\\SAINTexpress-spc",
                           input$msspc_interactions$datapath,
                           input$msspc_preys$datapath,
                           input$msspc_bait$datapath)
        system(cmd_saint)
        file.rename("list.txt", "msspc_list.txt")
      }
      if(input$int){
        req(input$msint_interactions,input$msint_preys,input$msint_bait)
        cmd_saint <- paste("Linux\\SAINTexpress-int.exe",
                           input$msint_interactions$datapath,
                           input$msint_preys$datapath,
                           input$msint_bait$datapath)
        system(cmd_saint)
        file.rename("list.txt", "msint_list.txt")
      } 
      if (input$merge_spc_int){
        merge<- merge(
          read.table(file= "msspc_list.txt", header = T, sep = "\t", stringsAsFactors = F),
          read.table(file = "msint_list.txt", header = T, sep = "\t", stringsAsFactors = F), 
          by = c("Bait", "Prey"), all = T)
        write.table(merge, 
                    "merged_list.txt", row.names = F, sep = "\t", quote = F)
      } }
      
      
    if(input$mac){
        if(input$spc){
          req(input$msspc_interactions,input$msspc_preys,input$msspc_bait)
        }
        if(input$int){
          req(input$msint_interactions,input$msint_preys,input$msint_bait)
        }
        if (input$merge_spc_int){} }
    
  })
}
