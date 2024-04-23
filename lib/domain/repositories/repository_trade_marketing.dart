import '../../data/model/trade_marketing_model.dart';

abstract class RepositoryTradeMarketing {
  Future<TradeMarketingEntity?> getTradeMarketing(String dateini, String datefin);
  Future<TradeMarketingPageModel?> getFormTradeMarketing(String docEntry);
}