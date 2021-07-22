package com.honjal.honjal.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.honjal.honjal.service.FileService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service("fileServiceV1")
public class FileServiceImplV1 implements FileService{

   @Autowired
   private ResourceLoader resLoader;
   
   @Override
   public String fileUp(MultipartFile file) throws Exception {
      // TODO Auto-generated method stub
      String originFileName=file.getOriginalFilename();
      Resource res=resLoader.getResource("/files");
      String filePath=res.getURI().getPath();
      String strUUID=UUID.randomUUID().toString();
      strUUID+=originFileName;
      File uploadPathAndFile=new File(filePath,strUUID);
      file.transferTo(uploadPathAndFile);
      return strUUID;
   }

   @Override
   public List<String> filesUp(MultipartHttpServletRequest files) throws Exception {
      // TODO Auto-generated method stub
      List<String>fileNames=new ArrayList<String>();
      String tagName="m_file";
      List<MultipartFile>fileList=files.getFiles(tagName);
      for(MultipartFile file:fileList) {
         String fileName=this.fileUp(file);
         fileNames.add(fileName);
      }
      return fileNames;
   }

   @Override
   public List<String> fileUp(MultipartFile file, MultipartHttpServletRequest files) throws Exception {
      // TODO Auto-generated method stub
      return null;
   }

   
}