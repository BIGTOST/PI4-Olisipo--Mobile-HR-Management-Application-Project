const BD = require('../models/bd.models');
const news = require('../models/news.models');
const logs = require('./logs.controller');

const controller = {};

controller.create = async (req,res) =>{
   const id = req.user.id;
   const {title, text,type} = req.body;
   const data = news.create({
      tittle:title,
      text:text,
      vis: true,
      madeby:id,
      aprovedBy:1,
      type:type,
      state:2,
   }).then((data)=>{
      logs.createLog('Nova noticia de Titulo: '+title+', criada pelo user de id: '+id+'.', id);
      return data
   }).catch(error=>{
      console.log('Erro na criação da news: ' +error);
      return error
   });
   res.status(200).json({
      success:true,
      message:"news Criado com sucesso",
      data:data
   });
   }

controller.list = async (req, res) => {
   const data = await news.findAll()
   .then((data)=>{
      return data
   })
   .catch(error=>{
      return error
   })
   res.json({
      success: true,
      message:'Boas novas encontradas',
      data: data
   })
}

controller.update = async (req,res)=>{
   const userId = req.user.id;
   const {id} = req.params;
    const {tittle, text} = req.body;
    const data = news.update({
      tittle:tittle,
      text:text,
   },{
      where:{idNews:id}
   }).then((data)=>{
      logs.createLog('Noticia de Titulo: '+title+', criada pelo user de id: '+id+'.', id);
     return data
   }).catch(error=>{
     console.log('Erro no update da news: ' +error);
     return error
  });
  res.status(200).json({
     success:true,
     message:"news updated com sucesso",
     data:data
  });
}

controller.delete = async (req,res)=>{
   const {id} = req.params;
    const data = news.update({
         vis:false
   },{
      where:{idNews:id}
   })
   .then((data)=>{
     return data
   })
   .catch(error=>{
     console.log('Erro no delete da news: ' +error);
     return error
  });
  res.status(200).json({
     success:true,
     message:"news deleted com sucesso",
     data:data
  });
}

module.exports = controller;