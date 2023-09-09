list_to_df = function(list){

  final.df = do.call(rbind.data.frame, list) |>  as.data.frame()

  return(final.df)

}
