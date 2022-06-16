//
//  EditProfileView.swift
//  NearCatch
//
//  Created by HWANG-C-K on 2022/06/13.
//

import SwiftUI

struct EditProfileView: View {
    @State var nickname:String
    @Binding var profileImage: UIImage?
    @State var isPresented = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("img_background")
                    .edgesIgnoringSafeArea([.top])
                VStack{
                    Spacer()
                    ZStack{
                        Button(action: {
                            withAnimation{
                                self.isPresented.toggle()
                            }
                        }) {
                            if self.profileImage == nil {
                                SharedCustomButton(icon:"icn_img", circleSize:190, color:Color.white, innerOpacity:1)
                            }
                            else {
                                ZStack{
                                    Circle()
                                        .fill(.white.opacity(0.3))
                                    Image(uiImage: self.profileImage!)
                                        .resizable()
                                        .clipShape(Circle())
                                        .scaledToFill()
                                        .frame(width: 200, height: 200)
                                        
                                }.frame(width: 190, height: 190)
                                    .padding(.top, 25)
                            }
                        }
                    }
                    Spacer()
                        .frame(height:50)
                    VStack {
                        ZStack {
                            TextField("", text: $nickname)
                                .font(.custom("온글잎 의연체", size:34))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                                .frame(width:200)
                                .textInputAutocapitalization(.never)
                            HStack{
                                Spacer()
                                    .frame(width:225)
                                if nickname != "" {
                                    Button {
                                        nickname = ""
                                    } label: {
                                        Image("icn_cancle")
                                            .resizable()
                                            .frame(width:25, height:25)
                                    }
                                }
                            }
                            
                        }
                        Rectangle()
                            .frame(width:260, height: 1)
                            .foregroundColor(.white)
                        Text("\(nickname.count) / 10")
                            .font(.custom("온글잎 의연체", size:30))
                            .foregroundColor((nickname.isEmpty || nickname.count > 10) ? Color.red : Color.white)
                        
                    }
                    Spacer()
                        .frame(height:180)
                    Button{
                        action: do { self.presentationMode.wrappedValue.dismiss() }
                    } label:{
                        SharedRectangularButton(rectWidth:350, rectColor:((nickname.isEmpty || nickname.count > 10) ? Color.gray : Color.PrimaryColor), text:"수정하기", textColor:((nickname.isEmpty || nickname.count > 10) ? Color.white : Color.black))
                    }.disabled(nickname.isEmpty || nickname.count > 10)
                    Spacer()
                }
                .sheet(isPresented: $isPresented) {
                    ImagePicker(profileImage: $profileImage, show: $isPresented)
                }
            }
            .toolbar{
                ToolbarItemGroup(placement:.navigationBarLeading) {
                    Button {
                    action: do { self.presentationMode.wrappedValue.dismiss() }
                    } label:{
                        SharedCustomButton(icon: "icn_chevron", circleSize:35, color:Color.white, innerOpacity:0.5)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(nickname:"마이즈", profileImage: .constant(nil))
    }
}