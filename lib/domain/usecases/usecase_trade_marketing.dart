import '../../data/model/trade_marketing_model.dart';
import '../../data/repositories/repository_trade_marketing_impl.dart';
import '../repositories/repository_trade_marketing.dart';

class UseCaseTradeMarketing {
  RepositoryTradeMarketing repositoryTradeMarketing = RepositoryTradeMarketingImpl();
  Future<TradeMarketingEntity?> getTradeMarketing(String dateini, String datefin) async {
    return await repositoryTradeMarketing.getTradeMarketing(dateini, datefin);
  }

  Future<TradeMarketingPageModel?> getFormTradeMarketing(String docEntry) async {
    return await repositoryTradeMarketing.getFormTradeMarketing(docEntry);
  }
}
