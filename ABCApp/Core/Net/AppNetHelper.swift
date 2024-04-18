//
//  AppNetHelper.swift
//  ABCApp
//
//  Created by Boris on 2024/1/22.
//

import UIKit
import Alamofire
import HandyJSON

class AppNetHelper: NSObject {

    
    class func post_uprightFingersAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.postAction(url: postuprightFingers, params: params, loading:true, success: success, fail: fail)
            
    }

    class func post_thoughtEveryoneAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.postAction(url: postthoughtEveryone, params: params, loading:true, success: success, fail: fail)
            
    }
    
    class func get_artifactsCondensedAction(success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.getAction(url: getartifactsCondensed, params: [:], loading:true, success: success, fail: fail)
    }
    
    class func post_destructionAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.postAction(url: postdestruction, params: params, loading:true, success: success, fail: fail)
            
    }
    
    class func post_getFaceAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.postAction(url: wirldWid, params: params, loading:true, success: success, fail: fail)
            
    }
    
    class func post_getPinction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.postAction(url: blueBlue, params: params, loading:true, success: success, fail: fail)
            
    }
    
    class func post_getPiafdaion(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.postAction(url: worldSole, params: params, loading:true, success: success, fail: fail)
            
    }
    
    class func post_weveAreAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.postAction(url: postweveAre, params: params, loading:true, success: success, fail: fail)
            
    }
    
    class func get_thickContainment(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.getAction(url: getthickContainment, params: params, loading:true, success: success, fail: fail)
            
    }
    
    class func get_icon(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){

        AppAFNetManager.postAction(url: getuidByOpes, params: params, loading:true, success: success, fail: fail)
    }
    
    class func post_helmetHoweverAction(params:[String:String], img:UIImage, success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.upPostAction(url: posthelmetHowever, params: params, img: img, loading:true, success: success, fail: fail)
            
    }
    
    class func post_imageAction(params:[String:String], img:UIImage, success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.upPostAction(url: querIsWo, params: params, img: img, loading:true, success: success, fail: fail)
            
    }
    
    class func post_theresLevelAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
     
        AppAFNetManager.postAction(url: posttheresLevel, params: params, loading:true, success: success, fail: fail)
            
    }
    
    class func post_afterStandAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postafterStand, params: params, loading:true, success: success, fail: fail)
    }
    
    class func get_askedCheeksAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.getAction(url: getaskedCheeks, params: params, success: success, fail: fail)
    }
    
    class func post_ticketCouldntAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postticketCouldnt, params: params, loading:true, success: success, fail: fail)
    }
    
    class func post_inevitableErasure(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postinevitableErasure, params: params, loading:true, success: success, fail: fail)
    }
    
    
    class func post_comesHolidayAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postcomesHoliday, params: params, loading:true, success: success, fail: fail)
    }
    
    class func post_drivenGreatAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postdrivenGreat, params: params, loading:true, success: success, fail: fail)
    }
    
    class func post_whoseStillAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postwhoseStill, params: params, loading:true, success: success, fail: fail)
    }
    
    class func get_sinisterAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.getAction(url: getsinister, params: params, loading:true, success: success, fail: fail)
    }
    
    
    class func post_sacrificeAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postsacrifice, params: params, loading:true, success: success, fail: fail)
    }
    
    class func post_abovegroundAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postaboveground, params: params, loading:true, success: success, fail: fail)
    }
    
    
    class func post_paperworkStairwellAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postpaperworkStairwell, params: params, loading:true, success: success, fail: fail)
    }
    
    class func post_turnedToxinsAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postturnedToxins, params: params, loading:true, success: success, fail: fail)
    }
    
    class func post_workedSkyscrapersAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postworkedSkyscrapers, params: params, loading:true, success: success, fail: fail)
    }
    
    
    
    class func post_angleCrowdsAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postangleCrowds, params: params, loading:true, success: success, fail: fail)
    }
    
    class func post_someoneMarnesAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postsomeoneMarnes, params: params, success: success, fail: fail)
    }
    
    class func post_peeredFrustrationAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postpeeredFrustration, params: params, success: success, fail: fail)
    }
    
    class func post_againOrbitAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postagainOrbit, params: params, success: success, fail: fail)
    }
    
    class func post_tongueMakingAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: posttongueMaking, params: params, success: success, fail: fail)
    }
    
    class func post_couldntKneesAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postcouldntKnees, params: params, success: success, fail: fail)
    }
    
    class func post_andWhereAction(params:[String:String],  success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        AppAFNetManager.postAction(url: postandWhere, params: params, loading:true, success: success, fail: fail)
    }
    
    class func get_kefudianhuaAction(success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()) {
        AppAFNetManager.getAction(url: getThinkBooks, params: ["green": "like"], loading:true, success: success, fail: fail)
    }
    
    class func get_throughMistakenAction(success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()) {
        AppAFNetManager.getAction(url: getthroughMistaken, params: ["traction": AppClassUtilsHelper.getRandomeStrAction(count: 10), "voices":AppClassUtilsHelper.getRandomeStrAction(count: 5)], loading:true, success: success, fail: fail)
    }
    
    
    
//
    
    
    
    
}
