mod_advplot_ui <- function(id){
  ns <- NS(id)
  tagList(
    sidebarPanel(
      width = 4,
      h3(strong("The main options:")),
      fileInput(ns("filetree"),"Choose Tree File to Upload(.newk):", accept = NULL),
      fileInput(ns("filegff"),"Choose Annotation File to Upload(.gff/.gtf):", accept = NULL),
      fileInput(ns("filememe"),"Choose MEME File to Upload(.xml):", accept = NULL),
      fileInput(ns("filepfam"),"Choose PFAM File to Upload(.tsv):", accept = NULL),
      fileInput(ns("filecdd"),"Choose CDD File to Upload(.txt):", accept = NULL),
      fileInput(ns("filepep"),"Choose Protein File to Upload(.fa/.fasta):", accept = NULL),
      
      fileInput(ns("fileplantcare"),"Choose plantcare File to Upload(.tab):", accept = NULL),
      numericInput(ns("prolength"),label = "Promoter Length",value = 2000),
      
      selectInput(ns("shapemotif"), label = "Element shape:",
                  c("RoundRect", "Rect")),
      
      numericInput(ns("roundr"),label = "RoundRect r value",value = 0.3),
      numericInput(ns("legendsize"),label = "Legend size",value = 6),
      
      textAreaInput(ns("code_input"),"Combination select:", placeholder = "e.g. p_tree + p_gff + p_pfam"),
      
      actionButton(ns("file_submit"), strong("Submit All Data"), styleclass = "success"),
      br(),
      br(),
      h3(strong("Download options:")),
      numericInput(ns("picheigh"),label = "Graph heigh value",value = 9.5),
      numericInput(ns("picwidth"),label = "Graph width value",value = 9.5),
      downloadButton(ns("downloadpic"),label = "Download Picture!"),
      
    ),
    
    mainPanel(
      h3("Advanced Plot:"),
      withSpinner(plotOutput(ns("plot_result"), width='80%', height='800px'))
    )
  )
}


mod_advplot_server <- function(input, output, session){
  ns <- session$ns

  
  element_plot <- eventReactive(input$file_submit,{
    plot_file <- combi_p(tree_path=input$filetree$datapath, gff_path = input$filegff$datapath,
                         meme_path = input$filememe$datapath, pfam_path = input$filepfam$datapath,
                         cdd_path = input$filecdd$datapath, fa_path = input$filefa$datapath,
                         plantcare_path = input$fileplantcare$datapath,
                         promoter_length = input$prolength, shape = input$shapemotif,
                         r = input$roundr, legend_size= input$legendsize
    )
    
    p_tree <- plot_file$p_tree
    p_gff <- plot_file$p_gff
    p_smart <-plot_file$p_smart
    p_cdd <- plot_file$p_cdd
    p_plantcare <- plot_file$p_plantcare
    p_meme <- plot_file$p_meme
    
    code_str <- input$code_input
    ele_num <- str_count(code_str, "\\+") +1
    code_loc <- paste(" + plot_layout(ncol = ", ele_num,
                      ") + plot_annotation(tag_levels = 'A')")
    code_combi <- paste(code_str, code_loc)
    eval(parse(text = code_combi))
  })
  
  output$plot_result <- renderPlot({
    element_plot()
  })
  
  
  output$downloadpic <- downloadHandler(
    filename = function() { 
      paste0("Advanced_plot", '.pdf')
    },
    contentType = "image/pdf",
    content = function(file) {
      pdf(file, width = input$picwidth, height = input$picheigh)
      print(element_plot())
      dev.off()
    }
  )
  
}
