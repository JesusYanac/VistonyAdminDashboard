import '../../data/model/trade_marketing_model.dart';
import '../../data/repositories/repository_trade_marketing_impl.dart';

class UseCaseTradeMarketing {
  Future<TradeMarketingEntity?> getTradeMarketing(String dateini, String datefin)async{

    //logica
    return await RepositoryTradeMarketingImpl().getTradeMarketing(dateini, datefin);
  }

  Future<TradeMarketingPageModel?> getFormTradeMarketing(String docEntry) async{
    return await RepositoryTradeMarketingImpl().getFormTradeMarketing(docEntry);
  }
}