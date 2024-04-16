import '../../data/model/trade_marketing_model.dart';
import '../../data/repositories/repository_trade_marketing_impl.dart';

class UseCaseTradeMarketing {
  Future<TradeMarketingEntity?> getTradeMarketing()async{
    return await RepositoryTradeMarketingImpl().getTradeMarketing();
  }

  Future<TradeMarketingPageModel?> getFormTradeMarketing() async{
    return await RepositoryTradeMarketingImpl().getFormTradeMarketing();
  }
}